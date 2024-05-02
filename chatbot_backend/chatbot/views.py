from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from django.http import HttpResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .modelML import ChatBot


@api_view(["POST"])
def chatbot_api(request):
    if request.method == "POST":
        message = request.POST.get("message")
        if message:
            channel_layer = get_channel_layer()
            async_to_sync(channel_layer.group_send)("chat", {"type": "on_message", "message": message})
            chatbot = ChatBot()  # Create an instance of the ChatBot class
            response = chatbot.generate_response(message)  # Call the method on the instance
            return Response({"response": response}, status=status.HTTP_200_OK)
            # return HttpResponse('Message sent.')
    return HttpResponse("Invalid request.")
