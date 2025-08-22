# dotfile

GPU-enabled GitHub Codespaces dev container.

## Use in GitHub Codespaces

1. Open this repository in GitHub and click "Code" > "Create codespace on main".
2. The Codespace will use the dev container in `.devcontainer/devcontainer.json`.
3. If the host supports GPUs for Codespaces, the container requests access to all GPUs.

Notes:
- GPU support in Codespaces is in limited/region-specific availability. If GPUs aren’t available, the container still works; GPU checks won’t fail your setup.
- CUDA 12.4 toolkit is installed via the NVIDIA devcontainer Feature.

## Verify GPU inside the container

This runs automatically after create:

- `nvidia-smi` and `nvcc --version` (if present)
- Device nodes `/dev/nvidia*`
- Optional PyTorch CUDA check

You can re-run manually:

```bash
bash .devcontainer/verify-gpu.sh
```

