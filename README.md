# Device tree for Poco F5 Pro | Redmi K60


## Specs
| Component | Specification                                               |
|:----------|:------------------------------------------------------------|
| SoC       | Snapdragon® 8+ Gen 1 (SM8475) 4nm                           |
| CPU       | Octa-core: 1x Cortex-X2 & 3x Cortex-A710 & 4x Cortex-A510   |
| GPU       | Adreno 730                                                  |
| Memory    | 8/12/16 GB RAM (LPDDR5)                                     |
| Storage   | 256/512/1024 GB (UFS 3.1)                                   |
| Battery   | Li-Po 5500 mAh , non-removable, 67W wired charging,
              20W wireless chargin                                        |
| Display   | 1440 x 3200 pixels, OLED,,560xxhdpi, 120 hz                 |
| Camera    | ov64b (Primary), ov08d1 (Ultra-wide), ov02b1 (Macro)        |

## Known issues
- Device Specific Issues:
- Fingerprint works on Goodix devices (most devices) and does not work on FPC devices.
- Q: How do you identify your fingerprint device? (Goodix or FPC)
- A: Install "Device Info HW" from GooglePlay to check it.

- PS：I only have a K60 of Goodix device, so I'm temporarily unable to fix this issue.

## Other issues:
To be submitted

## Kernel (Baalam Kernel)
- https://github.com/LowTension/android_kernel_xiaomi_sm8475

## Required system patches
- Check [project_changes.diff](https://github.com/flakeforever/device_xiaomi_mondrian/blob/main/project_changes.diff)

## Prebuilt files (customized from V14.0.26.0):
- https://drive.google.com/drive/folders/15Ihtjg5cZEeSgChfvwoYBC3Kv7HRyav4?usp=sharing


Credits: 
    [affggh](https://github.com/affggh)
    [johnmart19](https://github.com/johnmart19)
    [Klozz](https://github.com/Klozz)
    [LowTension](https://github.com/LowTension)

    
    
    
