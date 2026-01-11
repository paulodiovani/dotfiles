# Ollama Usage Guide

This guide explains how to use Ollama via Docker, including starting the container and basic commands for interacting with models.

## Starting the Ollama Docker Container

1. Ensure Docker is installed and running on your system.
2. From the root of your dotfiles repository, start the Ollama container:

```sh
docker compose up -d ollama
```

## Basic Ollama Commands (via Docker)

Use the provided alias (see `.bash_aliases`):

```sh
ollama <command>
```

This runs the `ollama` CLI inside the running container.

### Common Commands

```sh
# Use the ollama CLI inside the container (see .bash_aliases)
ollama <command>

# List available models
ollama list

# Pull a model
ollama pull <model-name>

# Run a model interactively
ollama run <model-name>

# Remove a model
ollama rm <model-name>
```

## Recommended Models

- **General chat, Q&A, writing:**
  - `llama2:7b`
  - `mistral:7b`
  - `gemma:7b` or `gemma:2b`
  - `phi:3`
- **Coding and reasoning:**
  - `codellama:7b`
  - `deepseek-coder:7b`
- **Lightweight/fast inference:**
  - `phi:3`
  - `tinyllama:1.1b`

> For best performance, prefer 7B parameter models. Larger models (13B+) may require more RAM and may not run efficiently on integrated graphics.

See the [Ollama model library](https://ollama.com/library) for more options.
