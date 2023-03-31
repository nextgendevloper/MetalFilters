//
//  Halftone.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;


float2 modulous(float2 x, float2 y) {
    return x - y * floor(x / y);
}

kernel void halftone(texture2d<half, access::write> outputTexture [[texture(0)]],
                           texture2d<half, access::sample> inputTexture [[texture(1)]],
                        
                           uint2 gid [[thread_position_in_grid]]) {
    float fractionalWidth = 0.5;
    if ((gid.x >= outputTexture.get_width()) || (gid.y >= outputTexture.get_height())) { return; }
    
    const float fractionalWidthOfPixel = float(fractionalWidth);
    const float aspectRatio = float(inputTexture.get_height()) / float(inputTexture.get_width());
    const float2 sampleDivisor = float2(fractionalWidthOfPixel, fractionalWidthOfPixel / aspectRatio);
    
    const float2 textureCoordinate = float2(float(gid.x) / outputTexture.get_width(), float(gid.y) / outputTexture.get_height());
    const float2 samplePos = textureCoordinate - modulous(textureCoordinate, sampleDivisor) + float2(0.5) * sampleDivisor;
    const float2 textureCoordinateToUse = float2(textureCoordinate.x, (textureCoordinate.y * aspectRatio + 0.5 - 0.5 * aspectRatio));
    const float2 adjustedSamplePos = float2(samplePos.x, (samplePos.y * aspectRatio + 0.5 - 0.5 * aspectRatio));
    const float distanceFromSamplePoint = distance(adjustedSamplePos, textureCoordinateToUse);
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    const half3 sampledColor = inputTexture.sample(quadSampler, samplePos).rgb;
    const float dotScaling = 1.0 - dot(float3(sampledColor), float3(0.2125, 0.7154, 0.0721));
    
    const half checkForPresenceWithinDot = 1.0 - step(distanceFromSamplePoint, (fractionalWidthOfPixel * 0.5) * dotScaling);
    const half4 outColor(half3(checkForPresenceWithinDot), 1.0h);
    outputTexture.write(outColor, gid);
}
