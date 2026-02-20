import { call, getSql, saveJson } from "./shared.js"
import {readFileSync} from 'fs'

const systemPrompt = `
You are a database expert specializing in SQL Server database analysis. 

your task is to fix the sql script based on the analysis result.
the result sql script should not have the issues mentioned in the analysis result.

return raw sql code. without markdown blocks and without any text other than sql`

const getAnalysis = () => {
    readFileSync('./datatype-result.json', 'utf-8') + readFileSync('./indexing-result.json', 'utf-8') + readFileSync('./keys-result.json', 'utf-8') + readFileSync('./keys-result.json', 'utf-8') + readFileSync('./normalization-result.json', 'utf-8') 
}
const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql() + "\n and Here is the analysis result: " + getAnalysis()})


const sql = JSON.parse(result.content)
saveJson('./fix-all-single-prompt-result-1.sql', sql)

