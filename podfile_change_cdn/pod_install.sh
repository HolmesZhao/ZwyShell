#!/bin/bash

# 替换 Podfile 中的 source 地址为 cdn
sed -i '' 's/source '"'"'https:\/\/github.com\/CocoaPods\/Specs.git'"'"'/source '"'"'https:\/\/cdn.cocoapods.org\/'"'"'/g' Podfile

# 执行 pod install --verbose
pod install --verbose

# 恢复 Podfile 中的 source 地址
sed -i '' 's/source '"'"'https:\/\/cdn.cocoapods.org\/'"'"'/source '"'"'https:\/\/github.com\/CocoaPods\/Specs.git'"'"'/g' Podfile
