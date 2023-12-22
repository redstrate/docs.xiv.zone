---
title: "Shader Package (.shpk)"
---

{{< note "This documentation is incomplete, nodes and keys are not documented yet." >}}

A collection of vertex and pixel shaders. For example, _"character.shpk"_ which contains shaders used for gear.

# Reading

At the beginning of the binary file is a simple header which describes what DirectX version the shader package is for, and the sizes of various structures.

## Header

```c++
struct ShaderPackageHeader {
    // Should be "ShPk" (capitalization intentional)
    uint8_t magic[4];

    // Reads "DX9\0" (\0 being a null byte) for DX9 shaders, and "DX11" for DX11 shaders
    uint8_t format[4];

    uint32_t fileLength;
    uint32_t shaderDataOffset;
    uint32_t stringsOffset;
    uint32_t vertexShaderCount;
    uint32_t pixelShaderCount;
    uint32_t materialParametersSize;
    uint32_t materialParameterCount;
    uint32_t scalarParameterCount;
    uint32_t resourceParameterCount;
    uint32_t uavParameterCount;
    uint32_t systemKeyCount;
    uint32_t sceneKeyCount;
    uint32_t materialKeyCount;
    uint32_t nodeCount;
    uint32_t nodeAliasCount;
};
```

Right after the header is the beginning of shader data. The process is identical between vertex and pixel shaders, and they're read in that order (the vertex shaders are all read first, and then the pixel shaders.)

```c++
struct Shader {
    uint32_t dataOffset;
    uint32_t dataSize;

    uint16_t scalarParameterCount;
    uint16_t resourceParameterCount;
    uint16_t uavParameterCount;

    uint16_t _unknown;

    ResourceParameter scalarParameters[scalarParameterCount];
    ResourceParameter resourceParameters[resourceParameterCount];
    ResourceParameter uavParameters[uavParameterCount];
};
```

Resource parameters are defined like so:

```c++
struct ResourceParameter {
    uint32_t id;
    uint32_t localStringOffset;
    uint32_t stringLength;
    uint16_t slot;
    uint16_t size;
};
```

The shaders are stored as DXBC bytecode (the bytecode used by DirectX before DXIL.) targetted to the shader level of their respective API as described in `format` above. The data blob starts at `ShaderPackageHeader::shaderDataOffset + Shader::dataOffset` to a length of `dataSize` bytes. To access the ResourceParameter name, they start at `ShaderPackageHeader::stringsOffset + ResourceParameter::localStringOffset` to a length of `stringLength` bytes.

# Alternative Implementations

* [SaintCoinach (C#)](https://github.com/xivapi/SaintCoinach/blob/master/SaintCoinach/Graphics/ShPk/ShPkFile.cs)
* [Physis (Rust)](https://git.sr.ht/~redstrate/physis/tree/main/item/src/shpk.rs)
