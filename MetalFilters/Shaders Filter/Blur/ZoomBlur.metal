//
//  ZoomBlur.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;




kernel void zoomBlur(texture2d<float, access::sample> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
    const float2 textureCoordinate = float2(float(position.x) / destination.get_width(), float(position.y) / destination.get_height());
    const float2 samplingOffset = 1.0 / 100.0 * (float2(0.5) - textureCoordinate) * float(intensity);

    constexpr sampler quadSampler(mag_filter::linear, min_filter::linear);
    float4 color = source.sample(quadSampler, textureCoordinate) * 0.18;

    color += source.sample(quadSampler, textureCoordinate + samplingOffset) * 0.15h;
    color += source.sample(quadSampler, textureCoordinate + (2.0h * samplingOffset)) *  0.12h;
    color += source.sample(quadSampler, textureCoordinate + (3.0h * samplingOffset)) * 0.09h;
    color += source.sample(quadSampler, textureCoordinate + (4.0h * samplingOffset)) * 0.05h;
    color += source.sample(quadSampler, textureCoordinate - samplingOffset) * 0.15h;
    color += source.sample(quadSampler, textureCoordinate - (2.0h * samplingOffset)) *  0.12h;
    color += source.sample(quadSampler, textureCoordinate - (3.0h * samplingOffset)) * 0.09h;
    color += source.sample(quadSampler, textureCoordinate - (4.0h * samplingOffset)) * 0.05h;
 
    
    destination.write(color, position);


}

