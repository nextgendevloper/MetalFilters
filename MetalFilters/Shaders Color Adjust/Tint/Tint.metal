//
//  Tint.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;




kernel void tint(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
     const float4 inColor = source.read(position);


    const half luminance = dot(inColor.rgb,  float3(0.2125, 0.7154, 0.0721));
    
    const float4 shadowResult = mix(inColor, max(inColor, float4(mix(float3(0.0), inColor.rgb, luminance), inColor.a)), float(intensity));
    const float4 highlightResult = mix(inColor, min(shadowResult, float4(mix(shadowResult.rgb, float3(0.0), luminance), inColor.a)), float(intensity));
    
    const float4 outColor(mix(shadowResult.rgb, highlightResult.rgb, luminance), inColor.a);
    
    destination.write(outColor, position);


}
