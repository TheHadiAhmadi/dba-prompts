import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a senior database expert. 


Review the following MySQL schema and check only for data type and storage efficiency issues.
suggest efficient alternatives.

if you created a note about an issue, you can skip it in the columns section.
and focus on other issues.

Output format should be below JSON object:
{
   notes: [
      { 
         content: string, 
         priority: 1 | 2 | 3 | 4 | 5 
      }
   ], // global suggestions which will apply for multiple tables
   columns: {
      table: string,
      column: string,
      priority: 1 | 2 | 3 | 4 | 5, // 1 means high
      suggestedType: string,
      reason: string,
   }
}

Don't include texts before and after json object. also avoid using \`\`\`json...
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./datatype-result.json', json)