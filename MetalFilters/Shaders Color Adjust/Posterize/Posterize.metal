//
//  Posterize.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void posterize(texture2d<half, access::write> outputTexture [[texture(0)]],
                        texture2d<half, access::read> inputTexture [[texture(1)]],
                      constant float *edgeStrength [[buffer(0)]],
                        uint2 grid [[thread_position_in_grid]]) {
    float colorLevelsPointer = *edgeStrength;
    const half4 inColor = inputTexture.read(grid);
    
    const half colorLevels = half(colorLevelsPointer);
    const half4 outColor = floor((inColor * colorLevels) + half4(0.5h)) / colorLevels;
    
    outputTexture.write(outColor, grid);
}
