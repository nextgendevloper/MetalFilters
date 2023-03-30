//
//  LuminousThersold.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;

kernel void luminousThersold(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
    const  float4 inColor = source.read(position);
    const float luminance = dot(inColor.rgb, float3(0.2125, 0.7154, 0.0721));
    const float thresholdResult = step(float(intensity), luminance/10.0);
    
    const float4 outColor(float3(thresholdResult), inColor.a);
    
    destination.write(outColor, position);


}

