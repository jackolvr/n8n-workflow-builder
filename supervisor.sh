#!/bin/sh

PID_FILE="/tmp/mcp-server.pid"

# Cleanup de processo anterior
cleanup() {
  if [ -f "$PID_FILE" ]; then
    kill $(cat "$PID_FILE") 2>/dev/null || true
    rm -f "$PID_FILE"
  fi
}

# Trap para cleanup ao sair
trap cleanup EXIT INT TERM

# Limpar ao iniciar
cleanup

# Iniciar MCP
node build/server.cjs &
echo $! > "$PID_FILE"

# Esperar processo terminar
wait