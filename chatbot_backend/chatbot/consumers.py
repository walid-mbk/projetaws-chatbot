from channels.generic.websocket import AsyncWebsocketConsumer

from .modelML import ChatBot


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()
        await self.channel_layer.group_add("chat", self.channel_name)
        await self.on_connect()

    async def disconnect(self):
        await self.channel_layer.group_discard("chat", self.channel_name)
        await self.on_disconnect()

    async def receive(self, text_data):
        await self.on_message(text_data)

    async def on_connect(self):
        print("Client connected")

    async def on_disconnect(self):
        print("Client disconnected")

    async def on_message(self, message):
        chatbot = ChatBot()  # Create an instance of the ChatBot class
        response = chatbot.generate_response(message)
        await self.send(response)
