//
//  Exposure.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;



kernel void exposure(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& effectValue [[ buffer(0) ]],
                        uint2 position [[thread_position_in_grid]]) {
    
    
//    if ((gid.x >= destination.get_width()) || (gid.y >= destination.get_height())) { return; }
    

    const float4 inColor = source.read(position);
    float red = inColor.r +(pow(2.0, effectValue));
    float green = inColor.g + (pow(2.0, effectValue));
    float blue = inColor.b + (pow(2.0, effectValue));
    const float4 outColor = float4(red,green,blue,inColor.a);
    destination.write(outColor, position);


}
