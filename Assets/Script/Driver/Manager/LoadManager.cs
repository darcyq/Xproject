using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniFramework.Event;
using YooAsset;
using System;
using System.IO;

public class LoadManager
{
    private static LoadManager _instance;
    public static LoadManager Instance
    {
        get
        {
            if (_instance == null)
                _instance = new LoadManager();
            return _instance;
        }
    }

    public Action<int,UnityEngine.Object> successCb;
    public Action<int> failCb;
    public Dictionary<int,YooAsset.AssetHandle> assetHandleMap = new Dictionary<int, AssetHandle>();
    
    public void LoadAsset(int index, string location,int assetType, string packageName = "DefaultPackage"){
            AssetHandle handle;
            switch(assetType) 
            {
                case 1:
                    handle = YooAssets.GetPackage(packageName).LoadAssetAsync<GameObject>(location);
                    assetHandleMap.Add(index,handle);
                    handle.Completed += (handle1)=>{
                        if(handle1.Status == EOperationStatus.Succeed){
                            if(successCb!= null){
                                successCb.Invoke(index,handle1.InstantiateSync());
                            }
                        }else if(handle1.Status == EOperationStatus.Failed){
                            if(failCb!= null){
                                failCb.Invoke(index);
                            }
                        }
                    };
                    break;
                // case 2:
                //     handle = YooAssets.GetPackage(packageName).LoadAssetAsync<GameObject>(location);
                //     break;
                default:
                    handle = YooAssets.GetPackage(packageName).LoadAssetAsync<GameObject>(location);
                    assetHandleMap.Add(index,handle);
                    handle.Completed += (handle1)=>{
                        if(handle1.Status == EOperationStatus.Succeed){
                            if(successCb!= null){
                                successCb.Invoke(index,handle1.GetAssetObject<GameObject>());
                            }
                        }else if(handle1.Status == EOperationStatus.Failed){
                            if(failCb!= null){
                                failCb.Invoke(index);
                            }
                        }
                    };
                    break;
            }
    }

    public void ReleaseAsset(int index){
        if(assetHandleMap.ContainsKey(index)){
            assetHandleMap[index].Dispose();
            assetHandleMap.Remove(index);
        }
    }

    public void GC(string packageName = "DefaultPackage"){
        YooAssets.GetPackage(packageName).ForceUnloadAllAssets();
    }
}