//
//  WhiteBalance.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;

constant half3 warmFilter = half3(0.93, 0.54, 0.0);

kernel void whiteBalance(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
    const  float4 inColor = source.read(position);

    
    const float3x3 RGBtoYIQ = float3x3(float3(0.299, 0.587, 0.114), float3(0.596, -0.274, -0.322), float3(0.212, -0.523, 0.311));
    const float3x3 YIQtoRGB = float3x3(float3(1.0, 0.956, 0.621), float3(1.0, -0.272, -0.647), float3(1.0, -1.105, 1.702));
    
    float3 yiq = RGBtoYIQ * inColor.rgb;
    yiq.b = clamp(yiq.b + float(intensity) * 0.5226 * 0.1, -0.5226, 0.5226);
    const float3 rgb = YIQtoRGB * yiq;
    
    const float3 processed = float3((rgb.r < 0.5 ? (2.0 * rgb.r * warmFilter.r) : (1.0 - 2.0 * (1.0 - rgb.r) * (1.0 - warmFilter.r))),
                                  (rgb.g < 0.5 ? (2.0 * rgb.g * warmFilter.g) : (1.0 - 2.0 * (1.0 - rgb.g) * (1.0 - warmFilter.g))),
                                  (rgb.b < 0.5 ? (2.0 * rgb.b * warmFilter.b) : (1.0 - 2.0 * (1.0 - rgb.b) * (1.0 - warmFilter.b))));
    
    const float4 outColor(mix(rgb, processed, half(0.0)), inColor.a);
    
    
    destination.write(outColor, position);


}
