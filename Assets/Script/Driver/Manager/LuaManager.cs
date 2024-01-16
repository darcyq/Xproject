using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniFramework.Event;
using YooAsset;
using System;
using XLua;
using System.IO;

public class LuaManager
{
    public LuaEnv luaEnv;

    public Action<float> updateFunc;
    public Action<float> fixedUpdateFunc;
    public Action destroyFunc;

    private static LuaManager _instance;
    public static LuaManager Instance
    {
        get
        {
            if (_instance == null)
                _instance = new LuaManager();
            return _instance;
        }
    }

    private LuaManager()
    {
        GameManager.Instance.RegisterUpdateFunc(Update);
        GameManager.Instance.RegisterFixedUpdateFunc(FixedUpdate);
        GameManager.Instance.RegisterDestroyFunc(Destroy);
    }

    public void StartLua(){
        GameManager.Instance.StartCoroutine(PrepareLuaFile());
    }

    public IEnumerator PrepareLuaFile(){
        yield return null;
        PrepareLuaEnv();
    }

    public void PrepareLuaEnv(){
        #if UNITY_EDITOR
        RecordMap();
        #endif
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(LuaLoader);
        luaEnv.DoString(@"require (""lua.main"") ");
    }

    public byte[] LuaLoader(ref string moduleName){
        if(GameDefine.useLocalLuaFile){
            string modulePath = moduleName.Replace('.','/');
            return File.ReadAllBytes($"{modulePath}.lua");
        }
        return null;
    }

    public void Update(){
        if(updateFunc!=null){
            updateFunc(Time.deltaTime);
        }
    }


    public void FixedUpdate(){
        if(fixedUpdateFunc!=null){
            fixedUpdateFunc(Time.deltaTime);
        }
    }

    public void Destroy(){
        if(destroyFunc!= null){
            destroyFunc();
        }
    }


    #region  hotfix
    public static Dictionary<string,long> luaFileMap;

    public static Dictionary<string,long> CollectLuaFileMap(){
        Dictionary<string,long> map = new Dictionary<string, long>();
        string luaFolder = $"{Application.dataPath}/../lua";
        string[] files = Directory.GetFiles(luaFolder,"*.lua",SearchOption.AllDirectories);
        foreach(string file in files){
            string key = file.Substring(file.IndexOf("lua\\")).Replace(".lua","").Replace("\\",".");
            map.Add(key,File.GetLastWriteTime(file).Ticks);
        }
        return map;
    }

    public static void RecordMap(){
        luaFileMap = CollectLuaFileMap();
    }

    #if UNITY_EDITOR
    [UnityEditor.MenuItem("Tools/Hotfix")]
    public static void HotFix(){
        List<string> files = new List<string>();
        Dictionary<string,long> map = CollectLuaFileMap();
        foreach(var oldFileKVP in luaFileMap){
            if(map.ContainsKey(oldFileKVP.Key)){
                if(map[oldFileKVP.Key] != oldFileKVP.Value){
                    files.Add(oldFileKVP.Key);
                }
            }
        }
        LuaFunction func = LuaManager.Instance.luaEnv.Global.Get<string,LuaFunction>("HotFix");
        func.Call(files);
    }
    #endif
    #endregion

}