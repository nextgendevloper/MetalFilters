//
//  PolkaDot.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void polkaDot(texture2d<half, access::write> outputTexture [[texture(0)]],
                       texture2d<half, access::sample> inputTexture [[texture(1)]],
                     constant float *edgeStrength [[buffer(0)]],
                       uint2 grid [[thread_position_in_grid]]) {
     float fractionalWidth = 0.005;
    float dotScaling = *edgeStrength;
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    
    const float fractionalWidthOfPixel = float(fractionalWidth);
    const float aspectRatio = float(inputTexture.get_height()) / float(inputTexture.get_width());
    const float2 sampleDivisor = float2(fractionalWidthOfPixel, fractionalWidthOfPixel / aspectRatio);
    const float2 textureCoordinate = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
    const float2 _mod = textureCoordinate - sampleDivisor * floor(textureCoordinate / sampleDivisor);
    const float2 samplePos = textureCoordinate - _mod + 0.5 * sampleDivisor;
    const float2 textureCoordinateToUse = float2(textureCoordinate.x, (textureCoordinate.y * aspectRatio + 0.5 - 0.5 * aspectRatio));
    const float2 adjustedSamplePos = float2(samplePos.x, (samplePos.y * aspectRatio + 0.5 - 0.5 * aspectRatio));
    const float distanceFromSamplePoint = distance(adjustedSamplePos, textureCoordinateToUse);
    const float checkForPresenceWithinDot = step(distanceFromSamplePoint, (fractionalWidthOfPixel * 0.5) * float(dotScaling));
    half4 outColor = inputTexture.sample(quadSampler, samplePos);
    outColor = half4(outColor.rgb * half(checkForPresenceWithinDot), outColor.a);
    
    outputTexture.write(outColor, grid);
}
