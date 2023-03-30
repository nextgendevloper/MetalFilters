//
//  Sharpness.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;

constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);

kernel void sharpness(texture2d<float, access::sample> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& sharpeness [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
    const float4 inColor = source.read(position);

    const float x = float(position.x);
    const float y = float(position.y);
    const float width = float(source.get_width());
    const float height = float(source.get_height());

    const float2 leftCoordinate = float2((x - 1) / width, y / height);
    const float2 rightCoordinate = float2((x + 1) / width, y / height);
    const float2 topCoordinate = float2(x / width, (y - 1) / height);
    const float2 bottomCoordinate = float2(x / width, (y + 1) / height);

   


    const float4 leftColor = source.sample(quadSampler, leftCoordinate);
    const float4 rightColor = source.sample(quadSampler, rightCoordinate);
    const float4 topColor = source.sample(quadSampler, topCoordinate);
    const float4 bottomColor = source.sample(quadSampler, bottomCoordinate);

    const half centerMultiplier = 1.0 + 4.0 * half(sharpeness);
    const half edgeMultiplier = half(sharpeness);
    const float4 outColor((inColor.rgb * centerMultiplier - (leftColor.rgb + rightColor.rgb + topColor.rgb + bottomColor.rgb) * edgeMultiplier), bottomColor.a);

    destination.write(outColor, position);


}
