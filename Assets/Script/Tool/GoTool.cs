using UnityEngine;

public static class GoTool{

    public static void SetPosition(GameObject go ,float x, float y, float z){
        go.transform.position = new Vector3(x,y,z);
    }

    public static void SetPosition2d(GameObject go, float x,float y ){
        go.transform.position = new Vector3(x,y,go.transform.position.z);
    }


    public static Component GetComponent(GameObject go , string type){
        if(go != null){
            Debug.Log(System.Type.GetType(type));
            return go.transform.GetComponent(System.Type.GetType(type));
        }
        return null;
    }   
}