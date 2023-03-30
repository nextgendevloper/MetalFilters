//
//  Luminous.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;



kernel void luminous(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& effectValue [[ buffer(0) ]],
                        uint2 position [[thread_position_in_grid]]) {

    const float4 inColor = source.read(position);
    const half luminance = dot(inColor.rgb, float3(0.2125*effectValue, 0.7154*effectValue, 0.0721*effectValue));
//    float red = inColor.r + effectValue/100;
//    float green = inColor.g + effectValue/100;
//    float blue = inColor.b + effectValue/100;
    const float4 outColor = float4(float3(luminance),inColor.a);
    destination.write(outColor, position);


}
