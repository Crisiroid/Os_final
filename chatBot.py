import tkinter as tk
import threading
import openai

# Set your OpenAI key in the environment variables or add it here
openai.api_key = "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"

class UserThread(threading.Thread):
    def __init__(self, user_id, chat_log):
        super(UserThread, self).__init__()
        self.user_id = user_id
        self.user_name = f"User {user_id}"
        self.chat_log = chat_log
        self.stop_thread = False

    def run(self):
        self.chat_log.insert(tk.END, f"{self.user_name} joined the chat..\n")
        while not self.stop_thread:
            message = self.chat_input.get().strip()
            if message == "":
                continue
            response = self.get_chat_response(message)
            self.chat_log.insert(tk.END, f"{self.user_name} says: {message}\n")
            self.chat_log.insert(tk.END, f"{self.user_name} chatbot says: {response}\n")
            self.chat_input.delete(0, tk.END)

    def stop(self):
        self.stop_thread = True

    def get_chat_response(self, message):
        response = openai.Completion.create(
            engine="davinci-codex",
            prompt=message,
            max_tokens=60,
            temperature=0.8,
            stop="\n"
        )
        return response.choices[0].text.strip()

NUM_USERS = 2

root = tk.Tk()
root.title("Chatbot")

chat_log = tk.Text(root, width=50, height=20, state=tk.DISABLED)
chat_log.pack(side=tk.TOP, padx=10, pady=10)

chat_input_frame = tk.Frame(root)
chat_input_frame.pack(side=tk.BOTTOM, padx=10, pady=10)

chat_input = tk.Entry(chat_input_frame, width=40)
chat_input.pack(side=tk.LEFT)

send_button = tk.Button(chat_input_frame, text="Send")
send_button.pack(side=tk.RIGHT)

threads = []
for i in range(NUM_USERS):
    thread = UserThread(i, chat_log)
    threads.append(thread)
    thread.start()
