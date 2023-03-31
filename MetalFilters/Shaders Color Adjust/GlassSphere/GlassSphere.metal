//
//  GlassSphere.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;

//float2 calculateAspectRatio

kernel void glassSphere(texture2d<half, access::write> outputTexture [[texture(0)]],
                          texture2d<half, access::sample> inputTexture [[texture(1)]],
                          constant float *radius [[buffer(0)]],
                          uint2 grid [[thread_position_in_grid]]) {
    
    float refractiveIndex = 0.1;
    float aspectRatio = inputTexture.get_height()/inputTexture.get_width();
    float centerX = 0.5;
    float centerY = 0.5;
    
    
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    
    const float _aspectRatio = float(aspectRatio);
    const float _radius = float(*radius);
    const float2 center = float2(centerX, centerY);
    const float2 textureCoord = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
    
    const float2 textureCoordinate = float2(textureCoord.x, (textureCoord.y * _aspectRatio + 0.5 - 0.5 * _aspectRatio));
    float distanceFromCenter = distance(center, textureCoordinate);
    float checkForPresenceWithinSphere = step(distanceFromCenter, _radius);
    
    distanceFromCenter = distanceFromCenter / _radius;
    
    float normalizedDepth = _radius * sqrt(1.0 - distanceFromCenter * distanceFromCenter);
    float3 sphereNormal = normalize(float3(textureCoordinate - center, normalizedDepth));
    
    float3 refractedVector = 2.0 * refract(float3(0.0, 0.0, -1.0), sphereNormal, float(refractiveIndex));
    refractedVector.xy = -refractedVector.xy;
    
    half3 finalSphereColor = half3(inputTexture.sample(quadSampler, (refractedVector.xy + 1.0) * 0.5).rgb);
    
    // Grazing angle lighting
    const float3 ambientLightPosition = float3(0.0, 0.0, 1.0);
    float lightingIntensity = 2.5 * (1.0 - pow(clamp(dot(ambientLightPosition, sphereNormal), 0.0, 1.0), 0.25));
    finalSphereColor += lightingIntensity;
    
    // Specular lighting
    const float3 lightPosition = float3(-0.5, 0.5, 1.0);
    lightingIntensity = clamp(dot(normalize(lightPosition), sphereNormal), 0.0, 1.0);
    lightingIntensity = pow(lightingIntensity, 15.0);
    finalSphereColor += half3(0.8, 0.8, 0.8) * half(lightingIntensity);
    
    const half4 outColor = half4(finalSphereColor, 1.0h) * half(checkForPresenceWithinSphere);
    outputTexture.write(outColor, grid);
}
