#!/bin/bash

# Fetch VRAM and GPU usage with nvidia-smi
vram_used=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
vram_total=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Calculate VRAM usage percentage
vram_percentage=$((vram_used * 100 / vram_total))

# Output the information for i3blocks
echo "GPU: ${gpu_usage}% | VRAM: ${vram_used}MiB/${vram_total}MiB (${vram_percentage}%)"
