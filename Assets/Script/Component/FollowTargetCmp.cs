using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using YooAsset;

public class FollowTargetCmp : MonoBehaviour
{
    public Transform target;
    public Vector3 offset;

    public void LateUpdate(){
        if(target != null){
            this.transform.position = target.position + offset;
        }
    }
}