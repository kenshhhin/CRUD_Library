const TelegramBot = require('node-telegram-bot-api');
const express = require('express')
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const dotenv = require('dotenv');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

dotenv.config();
const PORT = process.env.PORT;
const API_KEY_BOT = process.env.API_KEY_BOT;

const bot = new TelegramBot(API_KEY_BOT, {
    polling: true
});

const commands = [
    {
        command: "start",
        description: "Launching the bot"
    },
    {
        command: "unset notification",
        description: "Unsubscribe from the mailing list"
    },

]

bot.setMyCommands(commands);

bot.on('text', async msg => {
    try {
        if(msg.text === '/start') {
            await bot.sendMessage(msg.chat.id, `You have launched a bot!`);

            // ADDING TO THE MYSQL DB
            try {
                await prisma.notification_followers.create({
                    data: {
                        chatId: msg.chat.id
                    }
                })
            } catch (error) {
                await bot.sendMessage(msg.chat.id, "We have not forgotten about you, we will be announcing a new book 😊")
            } finally {
                await prisma.$disconnect();
            }
        } else if (msg.text === '/unsetnotification') {
            await prisma.notification_followers.delete({
                where: {
                    chatId: msg.chat.id
                }
            })
            await bot.sendMessage(msg.chat.id, "You have disabled the alerts, now we will not bother you. 😊")
        }
    }
    catch(error) {
        console.log(error);
    }
})

app.listen(PORT, () => {
    console.log(`Telegram Bot running on http://localhost:${PORT}`)
})

app.post('/info', async (req, res) => {
    try {
        const info = req.body;

        const users = await prisma.notification_followers.findMany();

        users.forEach(user => {
            bot.sendMessage(user.chatId, `We have added a new book! Called: ${info.title}`)
        });

        res.status(200).json();
    } catch (error) {
        console.error('Error retrieving user IDs:', error);
        res.status(500).json({ error: 'Internal server error.' });
    } finally {
        await prisma.$disconnect()
    }
});

