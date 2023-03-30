//
//  Vignette.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;



kernel void vignette(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& vignette [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
     const float4 inColor = source.read(position);


    const float d = distance(float2(float(position.x) / destination.get_width(), float(position.y) / destination.get_height()), float2(0.5));
    const half percent = smoothstep(float(0.05), float(vignette), d);
    const float4 outColor = float4(mix(inColor.rgb, float3(0.0), percent), inColor.a);

    destination.write(outColor, position);


}
