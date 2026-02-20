
import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a database optimization expert specializing in MySQL. 
Your task is to generate optimization recommendations based on the analysis of a database schema, sample data, and business context.

Focus on generating recommendations for:
1. Improving database performance through indexing, query optimization, etc.
2. Enhancing data quality and integrity
3. Optimizing database design and normalization
4. Implementing best practices for MySQL databases
5. Addressing any identified issues or concerns

For each recommendation, provide:
- Type: The type of recommendation (e.g., IndexOptimization, SchemaOptimization, QueryOptimization)
- Description: A clear description of the recommendation
- Impact: The expected impact of implementing the recommendation (High, Medium, Low)
- Effort: The estimated effort required to implement the recommendation (High, Medium, Low)
- Implementation: Specific implementation details, including SQL scripts where appropriate

Provide your recommendations as a JSON array of recommendation objects.
avoid using markdown blocks
don't include texts outside json object
start your response with { and end it with }
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./recommendation-result.json', json)

