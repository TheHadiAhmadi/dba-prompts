import { OpenAI } from 'openai'
import {readFileSync, writeFileSync} from 'fs'

const openai = new OpenAI({})

export async function call({systemPrompt, tools, userMessage}) {
    console.log('calling...')
    const response = await openai.chat.completions.create({
        model: 'qwen/qwen3-coder',
        // model: 'anthropic/claude-sonnet-4',
        messages: [
            {role: 'system', content: systemPrompt},
            {role: 'user', content: userMessage}
        ],
        tools
    }) 

    return response.choices[0].message
}

// export const getSql = () => readFileSync('./script.sql', 'utf-8')
export const getSql = () => readFileSync('./fix-all-single-prompt-result.sql', 'utf-8')

export const saveJson = (path, object) => writeFileSync(path, JSON.stringify(object, null, 4))
