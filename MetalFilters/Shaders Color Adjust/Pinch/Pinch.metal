//
//  Pinch.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;



kernel void pinch(texture2d<half, access::write> outputTexture [[texture(0)]],
                    texture2d<half, access::sample> inputTexture [[texture(1)]],
                  constant float *edgeStrength [[buffer(0)]],
                    uint2 grid [[thread_position_in_grid]]) {
    
    
    float centerPointerX = 0.5;
    float centerPointerY = 0.5;
    float radiusPointer = *edgeStrength;
     float scalePointer =  *edgeStrength * 2.0;
    
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    
    const float2 center = float2(centerPointerX, centerPointerY);
    const float radius = float(radiusPointer);
    const float scale = float(scalePointer);
    const float aspectRatio = float(inputTexture.get_height()) / float(inputTexture.get_width());
    
    const float2 inCoordinate = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
    float2 textureCoordinateToUse = float2(inCoordinate.x, inCoordinate.y * aspectRatio + 0.5 - 0.5 * aspectRatio);
    const float dist = distance(center, textureCoordinateToUse);
    textureCoordinateToUse = inCoordinate;
    
    if (dist < radius) {
        textureCoordinateToUse -= center;
        float percent = 1.0 + (0.5 - dist) / 0.5 * scale;
        textureCoordinateToUse = textureCoordinateToUse * percent + center;
    }
    
    const half4 outColor = inputTexture.sample(quadSampler, textureCoordinateToUse);
    outputTexture.write(outColor, grid);
}
