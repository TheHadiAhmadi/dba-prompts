import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a database expert specializing in SQL Server database analysis. 
Your task is to analyze the provided database schema information and provide insights about the structure, relationships, and design patterns.
Focus on identifying:
1. The overall database architecture and design patterns
2. Table relationships and dependencies
3. Potential normalization issues
4. Indexing strategies
5. Performance considerations

Provide your analysis in a structured JSON format with the following sections:
- tableAnalysis: Analysis of individual tables, their purpose, and structure. This is JSON array, each item has table name including schema name, purpose (string description), and structure fields (string description)
- relationshipAnalysis: Analysis of relationships between tables. This is JSON array, each item has related table name pair, description 
- designPatterns: Identified design patterns in the database. This is JSON array, each item has title, description 
- performanceInsights: Insights about potential performance issues. This is JSON array, each item has title, description, priority (1 to 5, 5 is very high)
- potentialIssues: Any potential issues or concerns with the database design. This is JSON array, each item has title, description, priority (1 to 5, 5 is very high)

Be thorough, technical, and precise in your analysis.You must respond with valid JSON only. Do not include any text, explanations, or formatting outside of the JSON structure. Your entire response must be parseable as JSON.

Requirements:
- Start your response with { and end with }
- Use proper JSON syntax with double quotes for strings
- Do not add any markdown formatting, code blocks, or explanations
- Do not include any text before or after the JSON
- Ensure all strings are properly escaped
- Verify your response is valid JSON before sending
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./all-single-prompt-result-1.json', json)

