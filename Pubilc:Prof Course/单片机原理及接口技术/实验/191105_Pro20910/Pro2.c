/************************************************************
*  ����: 74HC595�������������ʾ���֣�C���ԣ�             *
/*************************************************************/
#include <intrins.h>
#include<reg52.h>
#define  AT24C02 0xa0  //AT24C02 ��ַ
#define  NOP() _nop_()  /* �����ָ�� */
sbit MOSIO =P2^0;
sbit R_CLK =P2^1;
sbit S_CLK =P2^2;
void delay(unsigned int i);      //��������
void HC595SendData(unsigned char SendVal,unsigned char Wei);
void Led_Show(unsigned char Wei); 
void SetLedNum(unsigned long int Numcode);
void system_Ini();
void  keyscan(void);
void SengUart(unsigned char SenData);
void SendString(unsigned char *str);
void SengNum(unsigned int num);
// �˱�Ϊ LED ����ģ0    1    2    3    4    5    6   7    8    9    A    b    c    d    E    -    L   P    U    Hidden  _ (20)
unsigned char code Disp_Tab[] = { 0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90,0x88,0x83,0xC6,0xA1,0x86,0xbf,0xc7,0x8c,0xc1, 0xff,  0xf7 }; 
unsigned char code LED7Code[] = {~0x3F,~0x06,~0x5B,~0x4F,~0x66,~0x6D,~0x7D,~0x07,~0x7F,~0x6F,~0x77,~0x7C,~0x39,~0x5E,~0x79,~0x71};
unsigned char code Nuntable[]="0123456789abcdef";
unsigned char NumBuffer[8];
unsigned int LedNum=0; 
unsigned int time=0;
unsigned char P0flg;
unsigned char  temp;
unsigned char  key;               //��˳����
unsigned char ReData;
unsigned char pDat[8];
main()
{ 
   unsigned long int Num=0;
   P0=0xff;
   P1=0xff;
   P2=0xff;   
   system_Ini();   
   P0flg=0;
   NumBuffer[6]=pDat[5];
  while(1)
  {	 
		if(LedNum==0)
		{
			Num++;
			Num%=10000;
			SetLedNum(Num);
		}
	    keyscan();	
  }
}
/***********************************************************
purpose: ϵͳ��ʼ��
/**********************************************************/
void system_Ini()
{
    TMOD= 0x21;
	 TH0 = (65536-30000)>>8;    //12.000
	 TL0 = (65536-30000)&0xff;	
     ET0 =1;
     TR0  = 1;
     SCON = 0x50;  //REN=1�����н���״̬�����ڹ���ģʽ2 
	 TMOD|= 0x20;      //��ʱ��������ʽ2 
	 PCON|= 0x80;      //���������һ��                                                    
	 TH1 = 0xF3;// //baud*2  /* ������4800������λ8��ֹͣλ1��
     TL1 = 0xF3; 
	 TR1  = 1;        //������ʱ��1                                                      
ES   = 1;        //�������ж�
     IT0=1;           //�½��ش���
     EX0=1;		            
     EA   = 1;	      // �����ж� 
}
void SetLedNum(unsigned long int Numcode)
{
    unsigned char i;
    for(i=0;i<6;i++)
	{
		NumBuffer[i]=Numcode%10;
		Numcode/=10;
	}
}	
void Led_Show(unsigned char Wei)
{	 
    unsigned char  HC595SendVal;
	HC595SendVal = ~Disp_Tab[NumBuffer[Wei]];
	HC595SendData(HC595SendVal,Wei);	
}
void delay(unsigned int i)
{
    unsigned int j;
    for(i; i > 0; i--)
        for(j = 300; j > 0; j--);
}
/************************************************************
** ��������: HC595SendData
** ��������: ��SPI���߷�������
************************************************************/
void HC595SendData(unsigned char SendVal,unsigned char Wei)
{  
  unsigned char i;
  for(i=0;i<16;i++) 
   {
   	if(i<8)
	{
		if((SendVal<<i)&0x80) MOSIO=1; 
		else MOSIO=0;	   // ���Ϊ�� MOSIO = 1  
 	}
	else 
	{
	   MOSIO=((~(1<<Wei)>>(i-8))&0x01);
	}
	S_CLK=0;
	NOP();
	NOP();
	S_CLK=1;	
   }
  R_CLK=0; //set dataline low
  NOP();
  NOP();
  R_CLK=1; //Ƭѡ
}
void SengUart(unsigned char SenData)
{
	     SBUF=SenData;	             //SUBF����/���ͻ�����
	    while(TI==0);
         TI=0;
}
void SendString(unsigned char *str)
{
	while(*str!='\0')
	{
		SengUart(*str);
		str++;
	}
}
void SengNum(unsigned int num)
{
    unsigned char buffer[10];
	unsigned char *Buf=buffer+8;
	do{
	   *Buf=Nuntable[num%10];
	   Buf--;
	   num/=10;
	}while(num!=0);
	buffer[9]=0;
	Buf++;
	SendString(Buf);
}
 /*************************************************************/
/*��ɨ���ӳ���  (4*3 �ľ���) P1.4 P1.5 P1.6 P1.7Ϊ��      */
/*							  P1.1 P1.2 P1.3Ϊ��        */
/**************************************************************/
 void  keyscan(void)
 { 	temp = 0;
    P1=0xF0;            //����λ����   ��Ϊ�ߵ�ƽ  ��Ϊ�͵�ƽ
    delay(1);
	temp=P1;                 //��P1�� 
    temp=temp&0xF0;			 //���ε���λ
    temp=~((temp>>4)|0xF0);	  
    if(temp==1)	  // p1.4 ������
        key=0;
    else if(temp==2)   // p1.5 ������
        key=1;
    else if(temp==4)   // p1.6 ������
        key=2;
    else if(temp==8)   // p1.7 ������
         key=3;
    else
        key=16;  
    P1=0x0F;              //����λ����  ��Ϊ�ߵ�ƽ ��Ϊ�͵�ƽ
    delay(1);
	temp=P1;                //��P1��       
    temp=temp&0x0F;
    temp=~(temp|0xF0);
	if(temp==1)		   // p1.0  ������
        key=key+0;
    else if(temp==2)		   // p1.1  ������
        key=key+4;
    else if(temp==4)   // p1.2  ������
        key=key+8;
    else if(temp==8)	// p1.3  ������
        key=key+12;
    else
        key=16;	 
    if(key<16)
	{
    	NumBuffer[7]=key;
		SendString("get the key number: ");
		SengNum((unsigned int)key);
		SendString("\r\n");
		if(key==0)
		{
           	SendString("write num 5 to 24c02 !\r\n");	
		}
		else if(key==1)
		{
		    SendString("read num from 24c02 : ");
            NumBuffer[6]=pDat[0];		
			SengNum((unsigned int)pDat[0]);
			SendString("\r\n");
		}
	}
 }
/********************************************************
* INT0�жϺ���                                          *
********************************************************/
void  counter(void) interrupt 0 
{
   EX0=0;
   EX0=1;
}
/*************************************
 [ t1 (1ms)�ж�] �ж�
*************************************/
void T1zd(void) interrupt 1     //3��ʱ��0���жϺ�  1��ʱ��0���жϺ� 0�ⲿ�ж�1 2�ⲿ�ж�2  4�����ж�
{
	 TH0 = (65536-3000)>>8;    //12.000
	 TL0 = (65536-3000)&0xff;
	 time++;
	 if(time==10)
	 {
	    P0flg++;
		P0flg%=16;
	 	time = 0;
		if(P0flg<8)
		    P0=~(0x01<<P0flg);
		else
		    P0=~(0x80>>(P0flg-8));
	 }
   LedNum++;     //�жϼ���  
   LedNum%=8;
   Led_Show(LedNum); 
}
/****************************************************
               �����жϳ���
******************************************************/
void ser_int (void) interrupt 4 using 1
{
 if(RI == 1)        //RI�����жϱ�־
 {
 	RI = 0;		    //���RI�����жϱ�־
	ReData = SBUF;  //SUBF����/���ͻ�����
 }
}
