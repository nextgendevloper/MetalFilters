//
//  Swirl.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void swirl(texture2d<half, access::write> outputTexture [[texture(0)]],
                    texture2d<half, access::sample> inputTexture [[texture(1)]],
                  constant float *edgeStrength [[buffer(0)]],
                    uint2 grid [[thread_position_in_grid]]) {
    
    float centerPointerX = 0.5;
    float centerPointerY = 0.5;
    float radiusPointer =*edgeStrength;
     float anglePointer = 1.0;
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    
    const float2 center = float2(centerPointerX, centerPointerY);
    const float radius = float(radiusPointer);
    const float angle = float(anglePointer);
    
    float2 textureCoordinate = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
    const float dist = distance(center, textureCoordinate);
    
    if (dist < radius) {
        textureCoordinate -= center;
        const float percent = (radius - dist) / radius;
        const float theta = percent * percent * angle * 8.0;
        const float s = sin(theta);
        const float c = cos(theta);
        textureCoordinate = float2(dot(textureCoordinate, float2(c, -s)), dot(textureCoordinate, float2(s, c)));
        textureCoordinate += center;
    }
    
    const half4 outColor = inputTexture.sample(quadSampler, textureCoordinate);
    outputTexture.write(outColor, grid);
}
