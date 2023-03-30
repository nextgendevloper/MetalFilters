//
//  Hue.metal
//  MetalFilters
//
//  Created by HKBeast on 29/03/23.
//

#include <metal_stdlib>
using namespace metal;

// Hue Constants
constant float4 kRGBToYPrime = float4(0.299, 0.587, 0.114, 0.0);
constant float4 kRGBToI = float4(0.595716, -0.274453, -0.321263, 0.0);
constant float4 kRGBToQ = float4(0.211456, -0.522591, 0.31135, 0.0);

constant float4 kYIQToR = float4(1.0, 0.9563, 0.6210, 0.0);
constant float4 kYIQToG = float4(1.0, -0.2721, -0.6474, 0.0);
constant float4 kYIQToB = float4(1.0, -1.1070, 1.7046, 0.0);

kernel void hue(texture2d<float, access::read> source [[ texture(0) ]],
                        texture2d<float, access::write> destination [[ texture(1) ]],
                        constant float& intensity [[ buffer(0) ]],
                       uint2 position [[thread_position_in_grid]]) {
    
  
      float4 inColor = source.read(position);


    // Convert to YIQ
    float YPrime = dot(inColor, kRGBToYPrime);
    float I = dot(inColor, kRGBToI);
    float Q = dot(inColor, kRGBToQ);
    
    // Calculate the hue and chroma
    float hue = atan2(Q, I);
    float chroma = sqrt(I * I + Q * Q);
    
    // Make the user's adjustments
    hue -= float(intensity); //why negative rotation?
    
    // Convert back to YIQ
    Q = chroma * sin(hue);
    I = chroma * cos(hue);
    
    // Convert back to RGB
    float4 yIQ = float4(YPrime, I, Q, 0.0);
    inColor.r = dot(yIQ, kYIQToR);
    inColor.g = dot(yIQ, kYIQToG);
    inColor.b = dot(yIQ, kYIQToB);
    
    
    destination.write(inColor, position);


}
