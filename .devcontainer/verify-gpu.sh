#!/usr/bin/env bash
set -euo pipefail

echo "[verify-gpu] Checking NVIDIA GPU visibility..."
if command -v nvidia-smi >/dev/null 2>&1; then
  echo "[verify-gpu] nvidia-smi found. Printing GPU status:"
  nvidia-smi || true
else
  echo "[verify-gpu] nvidia-smi not found in PATH."
fi

echo "[verify-gpu] Checking CUDA compiler (nvcc)..."
if command -v nvcc >/dev/null 2>&1; then
  echo "[verify-gpu] nvcc version:"
  nvcc --version || true
else
  echo "[verify-gpu] nvcc not found."
fi

echo "[verify-gpu] Basic CUDA device probe via /dev/nvidia*..."
ls -l /dev/nvidia* 2>/dev/null || echo "[verify-gpu] No /dev/nvidia* devices."

echo "[verify-gpu] Python CUDA check (PyTorch optional)..."
if command -v python >/dev/null 2>&1; then
  python - <<'PY'
import sys
try:
    import torch
    print("torch:", torch.__version__)
    print("cuda_available:", torch.cuda.is_available())
    if torch.cuda.is_available():
        print("cuda_device_count:", torch.cuda.device_count())
        print("device_name_0:", torch.cuda.get_device_name(0))
except Exception as e:
    print("torch check skipped or failed:", e)
PY
else
  echo "[verify-gpu] Python not found; skipping PyTorch check."
fi

echo "[verify-gpu] Done."
