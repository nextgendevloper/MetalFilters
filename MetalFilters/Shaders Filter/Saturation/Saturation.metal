//
//  Saturation.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;


kernel void saturation(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& saturation [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
    const float4 inColor = source.read(position);
    const half luminance = dot(inColor.rgb,  float3(0.2125, 0.7154, 0.0721));
      const float4 outColor = float4(mix(float3(luminance), inColor.rgb, float(saturation)), inColor.a);
    destination.write(outColor, position);


}
