import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a database consultant helping to document a SQL Server database. 
Your task is to generate clarifying questions based on the analysis of the database schema and sample data.
These questions should help gather business context and understanding that is not evident from the technical analysis alone.

Focus on generating questions about:
1. The business purpose of specific tables and columns
2. The meaning of specific values or codes in the data
3. The business rules and workflows that the database supports
4. The relationships between entities from a business perspective
5. Any ambiguities or unclear aspects of the database design

Generate questions that are specific, clear, and will help improve the documentation and understanding of the database.
Return the questions as a JSON array of strings.
avoid using markdown blocks
don't include texts outside json object
start your response with [ and end it with ]
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./questions-result.json', json)

