//
//  Monochrome.metal
//  MetalFilters
//
//  Created by HKBeast on 03/04/23.
//

#include <metal_stdlib>
using namespace metal;

kernel void monochrome(texture2d<half, access::write> outputTexture [[texture(0)]],
                             texture2d<half, access::read> inputTexture [[texture(1)]],
                             constant float3 *filterColorInput [[buffer(1)]],
                             constant float *intensity [[buffer(0)]],
                             uint2 gid [[thread_position_in_grid]]) {
    
    if ((gid.x >= outputTexture.get_width()) || (gid.y >= outputTexture.get_height())) { return; }
    
    const half4 inColor = inputTexture.read(gid);
    
    const half luminance = dot(inColor.rgb, half3(0.2125, 0.7154, 0.0721));
    const half4 desat = half4(half3(luminance), 1.0);
    
    const half3 filterColor = half3(*filterColorInput);
    const half4 outputColor = half4((desat.r < 0.5 ? (2.0 * desat.r * filterColor.r) : (1.0 - 2.0 * (1.0 - desat.r) * (1.0 - filterColor.r))),
                                    (desat.g < 0.5 ? (2.0 * desat.g * filterColor.g) : (1.0 - 2.0 * (1.0 - desat.g) * (1.0 - filterColor.g))),
                                    (desat.b < 0.5 ? (2.0 * desat.b * filterColor.b) : (1.0 - 2.0 * (1.0 - desat.b) * (1.0 - filterColor.b))),
                                    1.0);
    
    const half4 outColor(mix(inColor.rgb, outputColor.rgb, half(*intensity)), inColor.a);
    outputTexture.write(outColor, gid);
}

