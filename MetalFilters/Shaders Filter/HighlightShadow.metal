//
//  HighlightShadow.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void highlightShadow(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
    const  float4 inColor = source.read(position);
    const float luminance = dot(inColor.rgb, float3(0.2125, 0.7154, 0.0721));
    const float shadow = clamp((pow(luminance, 1.0h / (float(intensity) + 1.0h)) + (-0.76) * pow(luminance, 2.0h / (float(intensity) + 1.0h))) - luminance, 0.0, 1.0);
    const float highlight = clamp((1.0 - (pow(1.0 - luminance, 1.0 / (2.0 - half(intensity))) + (-0.8) * pow(1.0 - luminance, 2.0 / (2.0 - half(intensity))))) - luminance, -1.0, 0.0);
    const float3 result = float3(0.0, 0.0, 0.0) + ((luminance +shadow+ highlight) - 0.0) * ((inColor.rgb - float3(0.0, 0.0, 0.0)) / (luminance - 0.0));
    
    const float4 outColor(result.rgb, inColor.a);
    
    destination.write(outColor, position);


}

