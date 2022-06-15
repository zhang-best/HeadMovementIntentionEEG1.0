using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class daojishi : MonoBehaviour
{
    public SerialPortController sp;/// <summary>
    public Sprite three;
    public Sprite two;
    public Sprite one;
    public Sprite zuo;
    public Sprite you;
    public Sprite blank;

    public Image cDownImage;

    ForceSensor force;
    public int index;//stringButton所使用的的传感器序号

    bool gameStarted;

    float pTime;
    int a;
    int tag;
    int Ftag;
    int trials;
    int[] shunxu1 = { 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1 };
    int[] shunxu2 = { 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0 };
    int[] shunxu3 = { 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1 };
    int[] shunxu4 = { 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0 };
    int[] shunxu5 = { 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1 };
    int[] shunxu6 = { 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0 };
    int[] shunxu7 = { 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1 };
    int[] shunxu8 = { 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0 };
    // Start is called before the first frame update
    void Start()
    {
        pTime = 0.0f;
        gameStarted = false;
        tag = 0;
        Ftag = 0;
        trials = 0;
        force = GameObject.Find("MP4623").GetComponent<ForceSensor>();
        sp = GameObject.Find("SerialPort").GetComponent<SerialPortController>();///////////
    }
  
    // Update is called once per frame
    void Update()
    {
        if (gameStarted == false)
        {
            if (pTime - 6.0f >= 0)
                cDownImage.overrideSprite = blank;
            else if (pTime - 4.0f >= 0&& pTime - 6.0f <= 0)
            {
                if (tag == 0)
                {
                    a = shunxu1[trials];        //调用shunxu数组
                }
                if (a < 0.5)
                {
                    cDownImage.overrideSprite = zuo;
                    tag = 1;
                    //Marker 1
                    byte[] marker = new byte[5] { 0x01, 0xE1, 0x01, 0x00, 0x01 };//////////////
                    sp.WriteData(marker);////////////////
                }
                if (a > 0.5)
                {
                    cDownImage.overrideSprite = you;
                    tag = 2;
                    //Marker 2
                    byte[] marker = new byte[5] { 0x01, 0xE1, 0x01, 0x00, 0x02 };/////////
                    sp.WriteData(marker);///////////
                }
            }
            else if (pTime - 3.0f >= 0)
                cDownImage.overrideSprite = one;
            else if (pTime - 2.0f >= 0)
                cDownImage.overrideSprite = two;
            else if (pTime - 1.0f >= 0)
                cDownImage.overrideSprite = three;

            float currentF = force.fsl.m_FingerForce[index];
            if (pTime - 4.0f >= 0 && Ftag == 0 && currentF>=0.5)
            {
                ///Marker 2
                byte[] marker = new byte[5] { 0x01, 0xE1, 0x01, 0x00, 0x03 };/////////
                sp.WriteData(marker);
                Ftag = 1;
            }

            pTime += Time.deltaTime;

            if (pTime -7.0f >= 0)
            {//倒计时结束
                //
                pTime = 0.0f;
                tag = 0;
                Ftag = 0;
                trials++;
                if (trials == 26)
                {
                    gameStarted = true;
                    cDownImage.gameObject.SetActive(false);
                }  
            }
        }

    }
}
