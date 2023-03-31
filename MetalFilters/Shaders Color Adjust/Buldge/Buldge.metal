//
//  Buldge.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;

kernel void bludge(texture2d<half, access::write> outputTexture [[texture(0)]],
                    texture2d<half, access::sample> inputTexture [[texture(1)]],
                   constant float *edgeStrength [[buffer(0)]],
                    uint2 grid [[thread_position_in_grid]]) {
    
    float centerPointerX = 0.5;
    float centerPointerY = 0.5;
    float radiusPointer = *edgeStrength;
    float scalePointer =  *edgeStrength * 2.0;
    
    
    const float2 center = float2(centerPointerX, centerPointerY);
    const float radius = float(radiusPointer);
    const float scale = float(scalePointer);
    const float aspectRatio = float(inputTexture.get_height()) / float(inputTexture.get_width());
    
    const float2 inCoordinate = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
    float2 textureCoordinate = float2(inCoordinate.x, (inCoordinate.y - center.y) * aspectRatio + center.y);
    const float dist = distance(center, textureCoordinate);
    textureCoordinate = inCoordinate;
    
    if (dist < radius) {
        textureCoordinate -= center;
        float percent = 1.0 - (radius - dist) / radius * scale;
        percent = percent * percent;
        textureCoordinate = textureCoordinate * percent + center;
    }
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    const half4 outColor = inputTexture.sample(quadSampler, textureCoordinate);
    outputTexture.write(outColor, grid);
}

