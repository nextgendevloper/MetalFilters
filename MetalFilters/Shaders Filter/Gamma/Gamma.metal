//
//  Gamma.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;



kernel void gamma(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& effectValue [[ buffer(0) ]],
                        uint2 position [[thread_position_in_grid]]) {

    const float4 inColor = source.read(position);
 
    const float4 outColor = pow(inColor.rgba, float4(effectValue));
    destination.write(outColor, position);


}
