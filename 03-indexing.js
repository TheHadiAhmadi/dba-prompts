import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a senior database expert. 

Review the following MySQL schema and queries. Check only for indexing issues (e.g., missing indexes, redundant indexes, unused indexes, poor index choice).
Suggest efficient alternatives or confirm when indexing is fine (by returning empty array for indexes field).

Output format should be below JSON object:
{
  "notes": [
    { "content": "string", "priority": 1 | 2 | 3 | 4 | 5 }
  ],
  "indexes": [
    {
      "table": "string",
      "issue": "missing_index | unused_index | redundant_index | suboptimal_index",
      "priority": 1 | 2 | 3 | 4 | 5,
      "suggestedIndex": "string",
      "reason": "string"
    }
  ]
}

 don't include texts before and after json object. also avoid using \`\`\`json...
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./indexing-result.json', json)