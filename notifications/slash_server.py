"""
Lightweight Slack slash command server.
Responds to /to-do's with the formatted to-do summary.

Usage:
  python3 slash_server.py

Then expose via ngrok or deploy to a cloud provider.
"""

import json
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import parse_qs

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TODOS_FILE = os.path.join(SCRIPT_DIR, "todos.json")
PORT = int(os.environ.get("PORT", 3000))


def build_message():
    with open(TODOS_FILE, "r") as f:
        data = json.load(f)

    lines = []
    for i, item in enumerate(data["todos"], 1):
        links = item["links"]
        link_parts = ", ".join(
            f"<{url}|Link {j}>" for j, url in enumerate(links, 1)
        )
        lines.append(f"{i}) {item['task']} ({link_parts})")

    return "\n".join(lines)


class SlashHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode()
        params = parse_qs(body)

        message = build_message()

        response = json.dumps({
            "response_type": "ephemeral",
            "text": f":memo: *Justin's To-Do Summary*\n\n{message}"
        })

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(response.encode())

    def log_message(self, format, *args):
        print(f"[slash_server] {args[0]}")


if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", PORT), SlashHandler)
    print(f"Slash command server running on port {PORT}")
    print(f"Set your Slack slash command Request URL to: http://<your-host>:{PORT}/")
    server.serve_forever()
