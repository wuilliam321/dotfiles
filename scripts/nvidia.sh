#!/bin/bash

# Fetch VRAM and GPU usage with nvidia-smi
vram_used=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
vram_total=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Vram in GB
vram_used=$(($vram_used / 1024))
vram_total=$(($vram_total / 1024))

# Calculate VRAM usage percentage
vram_percentage=$((vram_used * 100 / vram_total))

# Output the information for i3blocks
printf "GPU %.2f%% | VRAM %.1fG/%.1fG (%.1f%%)\n", ${gpu_usage}, ${vram_used}, ${vram_total}, ${vram_percentage}
