using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using YooAsset;

public class Driver : MonoBehaviour
{
    /// <summary>
    /// 资源系统运行模式
    /// </summary>
    public EPlayMode PlayMode = EPlayMode.EditorSimulateMode;

    void Awake()
    {
        Debug.Log($"资源系统运行模式：{PlayMode}");
        GameDefine.PlayMode = PlayMode;
        Application.targetFrameRate = 60;
        Application.runInBackground = false;
        DontDestroyOnLoad(this.gameObject);
    }
    IEnumerator Start()
    {
        // 游戏管理器
        GameManager.Init();

        // 初始化资源系统
        YooAssets.Initialize();

        // 加载更新页面
        // todo

        // 开始补丁更新流程
        PatchOperation operation = new PatchOperation("DefaultPackage", EDefaultBuildPipeline.BuiltinBuildPipeline.ToString(), PlayMode);
        YooAssets.StartOperation(operation);
        yield return operation;

        // 设置默认的资源包
        var gamePackage = YooAssets.GetPackage("DefaultPackage");
        YooAssets.SetDefaultPackage(gamePackage);

        LuaManager.Instance.StartLua();
    }
}