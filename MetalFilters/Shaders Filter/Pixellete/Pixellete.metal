////
////  Pixellete.metal
////  MetalFilters
////
////  Created by HKBeast on 29/03/23.
////
//
#include <metal_stdlib>

using namespace metal;

float2 mod_dub(float2 x, float2 y) {
    return x - y * floor(x / y);
}

kernel void pixellete(texture2d<float, access::sample> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& pixellete [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
//     const float4 inColor = source.read(position);

    const float2 sampleDivisor = float2(float(pixellete/10.0), float(pixellete/10.0) * float(source.get_width()) / float(source.get_height()));
    const float2 textureCoordinate = float2(float(position.x) / destination.get_width(), float(position.y) / destination.get_height());
    const float2 samplePos = textureCoordinate - mod_dub(textureCoordinate, sampleDivisor) + float2(0.2) * sampleDivisor;
    
    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    const float4 outColor = source.sample(quadSampler, samplePos);

    destination.write(outColor, position);


}
