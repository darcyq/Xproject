using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniFramework.Event;
using YooAsset;
using System;

public class GameManager:MonoBehaviour
{
    private static GameManager _instance;
    public static GameManager Instance
    {
        get
        {
            if (_instance == null)
                Init();
            return _instance;
        }
    }

    public static void Init(){
        if (_instance == null){
            GameObject gameManager = new GameObject("GameManager");
            GameObject.DontDestroyOnLoad(gameManager);
            _instance = gameManager.AddComponent<GameManager>();
        }
    }

    private GameManager()
    {
    }

    public List<Action> updateList = new List<Action>();
    public List<Action> fixedupdateList = new List<Action>();
    public List<Action> destroyList = new List<Action>();
    public void RegisterUpdateFunc(Action func){
        updateList.Add(func);
    }
    public void UnregisterUpdateFunc(Action func){
        updateList.Remove(func);
    }

    public void RegisterFixedUpdateFunc(Action func)
    {
        fixedupdateList.Add(func);
    }

    public void UnregisterFixedUpdateFunc(Action func)
    {
        fixedupdateList.Remove(func);
    }

    public void RegisterDestroyFunc(Action func)
    {
        destroyList.Add(func);
    }

    public void UnregisterDestroyFunc(Action func)
    {
        destroyList.Remove(func);
    }
    public void OnDestroy()
    {
        for (int i = 0; i < destroyList.Count; i++)
        {
            destroyList[i]();
        }
    }

    public void Update()
    {
        for (int i = 0; i < updateList.Count; i++)
        {
            updateList[i]();
        }
    }

    public void FixedUpdate()
    {
        for(int i = 0; i < fixedupdateList.Count; i++)
        {
            fixedupdateList[i]();
        }
    }

    // /// <summary>
    // /// 开启一个协程
    // /// </summary>
    // public void StartCoroutine(IEnumerator enumerator)
    // {
    //     Behaviour.StartCoroutine(enumerator);
    // }
}