Shader "MMI/OutlineShader"
{
    Properties
    {
        _Color("Main Color", Color) = (1, 0.92, 0.016, 1)
        _MainTex ("Texture", 2D) = "white" {}
        _OutLineColor("Outline color", Color) = (1, 0.92, 0.016, 1)
        _OutlineWidth("Outline width", Range(1.0,5.0)) = 1.01
    }

    //HLSLINCLUDE
    CGINCLUDE
    #include "UnityCG.cginc"
//#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
//#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"
//#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Version.hlsl"
//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderVariablesFunctions.hlsl"
//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Deprecated.hlsl"

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
        };

        struct v2f
        {
            float4 pos : POSITION;
            float3 normal : NORMAL;
        };

        float _OutlineWidth;
        float4 _OutlineColor;

        v2f vert(appdata v)
        {
            v.vertex.xyz *= _OutlineWidth;

            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            return o;
        }

        ENDCG
        //ENDHLSL

        SubShader
        {
            Tags { "Queue" = "Transparent" }
            //Render the Outline
            Pass
            {
                ZWrite Off

                //HLSLPROGRAM
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                half4 frag(v2f i) : COLOR
                {
                    return _OutlineColor;
                }
                ENDCG
                //ENDHLSL
            }
        
            //Normal Rendering
            Pass
            {
                ZWrite On

                Material
                {
                    Diffuse[_Color]
                    Ambient[_Color]
                }

                Lighting On

                SetTexture[_MainTex]
                {
                    ConstantColor[_Color]

                }

                SetTexture[_MainTex]
                {
                    Combine previous * primary DOUBLE
                }


            }

        }

}
