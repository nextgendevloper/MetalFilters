//
//  CrossHetch.metal
//  MetalFilters
//
//  Created by HKBeast on 30/03/23.
//

#include <metal_stdlib>
using namespace metal;

METAL_FUNC float mod(float x, float y) {
    return x - y * floor(x / y);
}


kernel void crossHetch(texture2d<half, access::write> outputTexture [[texture(0)]],
                     texture2d<half, access::read> inputTexture [[texture(1)]],
                       constant float *edgeStrength [[buffer(0)]],
                     uint2 grid [[thread_position_in_grid]]) {
const half4 inColor = inputTexture.read(grid);
    float crossHatchSpacingPointer = *edgeStrength/10;
    float lineWidthPointer = *edgeStrength/100;

const float2 coordinate = float2(float(grid.x) / outputTexture.get_width(), float(grid.y) / outputTexture.get_height());
const float spacing = float(crossHatchSpacingPointer);
const float lineWidth = float(lineWidthPointer);

const half3 luminanceWeighting = half3(0.2125, 0.7154, 0.0721);
const half luminance = dot(inColor.rgb, luminanceWeighting);

const bool black1 = (luminance < 1.00) && (mod(coordinate.x + coordinate.y, spacing) <= lineWidth);
const bool black2 = (luminance < 0.75) && (mod(coordinate.x - coordinate.y, spacing) <= lineWidth);
const bool black3 = (luminance < 0.50) && (mod(coordinate.x + coordinate.y - (spacing / 2.0), spacing) <= lineWidth);
const bool black4 = (luminance < 0.30) && (mod(coordinate.x - coordinate.y - (spacing / 2.0), spacing) <= lineWidth);
const bool displayBlack = black1 || black2 || black3 || black4;

const half4 outColor = displayBlack ? half4(0.0h, 0.0h, 0.0h, 1.0h) : half4(1.0h);
outputTexture.write(outColor, grid);
}
