using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using MMIAPITestModelClasses;
using Proyecto26; 

public class TestScript_1 : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        AuthTokenGeneration authToken = new AuthTokenGeneration();
        authToken.grant_type = "client_credentials";
        authToken.client_secret = "test_secret";
        authToken.client_id = "test_id";
        GetAuthToken(authToken);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public static void GetAuthToken(AuthTokenGeneration authToken)
    {
        string authAPI = "https://outpost.mapmyindia.com/api/security/oauth/token";

        RequestHelper requestOptions = new RequestHelper
        {
            Uri = authAPI,
            Headers = new Dictionary<string, string>
            {

                { "accept", "application/json" },
                //{ "Content-Type", "application/x-www-form-urlencoded" },
                { "Content-Type", "application/json" },
            },
            Body = authToken
            //Params = new Dictionary<string, string>
            //{
            //    {"grant_type", authToken.grant_type },
            //    {"client_secret", authToken.client_secret },
            //    {"client_id", authToken.client_secret }
            //}
        };
        Debug.Log(JsonUtility.ToJson(requestOptions.Body));
        //Debug.Log(JsonUtility.ToJson(requestOptions.Params));
        RestClient.Post(requestOptions).Then(res =>
        {
            Debug.Log($"Response : {res.Text}");

        }).Catch(err =>
        {
            Debug.Log($"Error : {err}");
        });
    }
}
