//
//  Vibrance.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void vibrance(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& vibrance [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
     float4 inColor = source.read(position);

   
    
    const half average = (inColor.r + inColor.g + inColor.b) / 3.0;
    const half mx = max(inColor.r, max(inColor.g, inColor.b));
    const half amt = (mx - average) * (-float(vibrance) * 3.0);
    inColor.rgb = mix(inColor.rgb, float3(mx), amt);

    destination.write(float4(inColor.rgb,inColor.a), position);


}
